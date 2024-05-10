import json, glob
from django.db import migrations, transaction, IntegrityError

def int_or_none(n):
    if n == '' or n is None:
        return None
    return int(n)

def add_crosses(apps, schema_editor):
    missing_plr = set()
    TieredValidCrosses = apps.get_model("rules", "TieredValidCrosses")
    Rule = apps.get_model("rules", "Rule")
    data = None
    i = 0
    files_list = glob.glob('db_data/rules/rules_*.json')
    print('\n')
    for fn in files_list:
        try:
            with open(fn, 'r+', encoding='utf-8') as f:
                data = json.load(f)
        except:
            print(f'fnf: {fn}')
        if data is None:
            return
        for k in data.keys():
            rle = data[k]
            try:
                with transaction.atomic():
                    db_rle = Rule.objects.get(key=rle['key'])
                    db_vc = TieredValidCrosses()
                    db_vc.rule = db_rle
                    db_vc.save()
                    for l in rle['valid_crosses'].keys():
                        for vc in rle['valid_crosses'][l]:
                            try:
                                db_cross = Rule.objects.get(key=vc)
                                if l.lower() == 'primary':
                                    db_vc.primary.add(db_cross)
                                elif l.lower() == 'secondary':
                                    db_vc.secondary.add(db_cross)
                                db_vc.save()
                            except Rule.DoesNotExist as e:
                                missing_plr.add(vc)
            except IntegrityError:
                pass
        print(f'\rfinished {i}/{len(files_list)}', end='', flush=True)
        i += 1
    print(f"missing players {missing_plr}")


class Migration(migrations.Migration):

    dependencies = [
        ('rules', '0008_add_rules_data'),
    ]

    operations = [
        migrations.RunPython(add_crosses)
    ]
