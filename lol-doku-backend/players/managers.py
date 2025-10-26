from django.contrib.postgres.search import (
    SearchVector,
    SearchQuery,
    SearchRank,
    TrigramSimilarity,
)
from django.db.models.functions import Coalesce
from django.db import models


class PersonQuerySet(models.QuerySet):
    def search(self, term: str):
        if not term:
            return self

        term_value = models.Value(term, output_field=models.TextField())
        query = SearchQuery(term)

        from .models import PlayerAlternateName

        # Subquery: max trigram similarity per person for alternate names
        max_alt_sim_subquery = (
            PlayerAlternateName.objects.filter(player_name_id=models.OuterRef("pk"))
            .annotate(sim=TrigramSimilarity("alternate_name", term_value))
            .order_by("-sim")
            .values("sim")[:1]  # pick the highest similarity
        )

        return (
            self.annotate(
                vector=SearchVector("display_name", weight="A"),
                rank=SearchRank(models.F("vector"), query),
                trigram=models.functions.Greatest(
                    models.Value(3.0, output_field=models.FloatField())
                    * TrigramSimilarity("display_name", term_value),
                    models.Value(2.0, output_field=models.FloatField())
                    * models.Subquery(
                        max_alt_sim_subquery, output_field=models.FloatField()
                    ),
                    models.Value(1.0, output_field=models.FloatField())
                    * TrigramSimilarity("real_name", term_value),
                    output_field=models.FloatField(),
                ),
            )
            .annotate(
                final_score=Coalesce(
                    models.F("rank"),
                    models.Value(0.0, output_field=models.FloatField()),
                )
                + models.F("trigram")
            )
            .filter(final_score__gt=0)
            .order_by("-final_score")
        )
