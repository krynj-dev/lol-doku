import time, codecs

from mwrogue.esports_client import EsportsClient

site = EsportsClient("lol")

responses = []
offset = 0
while True:
    print("Getting page {}".format(offset // 500 + 1))
    response = site.cargo_client.query(
        tables="TeamRenames=TR",
        fields="TR.OriginalName, TR.NewName, TR.Verb",
        offset=offset,
        order_by="TR.Date",
        limit=500
    )
    if len(response) == 0:
        break
    responses += response
    offset += 500
    print("Sleeping 0.5s")
    time.sleep(0.5)

print(len(responses))

for i in responses:
    if "H2k" in i["OriginalName"] or "H2k" in i["NewName"]:
        print(i)

team_chains = []
for rename in responses:
    # Check old or new name existing
    idx_old = next((i for i, v in enumerate(team_chains) if rename["OriginalName"] == v[-1]), None)
    # idx_new = next((i for i, v in enumerate(team_chains) if rename["NewName"] in v), None)
    # if idx_old is not None and idx_new is not None and idx_new != idx_old:
    #     # print("{}->{}\t{} and {}\t{} and {}".format(rename["OriginalName"], rename["NewName"], idx_old, idx_new, team_chains[idx_old], team_chains[idx_new]))
    #     # raise Exception("WTF happened here")
    #     #Merge
    #     old_one = team_chains[idx_old]
    #     new_one = team_chains[idx_new]
    #     merged = [t for t in old_one]
    #     for t in new_one:
    #         if t not in merged:
    #             merged.append(t)
    #     idx_ordered = sorted([idx_old, idx_new])
    #     del(team_chains[idx_ordered[0]])
    #     del(team_chains[idx_ordered[1]-1])
    #     team_chains.append(merged)
    # elif idx_old is not None and rename["NewName"] not in team_chains[idx_old]:
    #     team_chains[idx_old].append(rename["NewName"])
    # elif idx_new is not None and rename["OriginalName"] not in team_chains[idx_new]:
    #     team_chains[idx_new].append(rename["OriginalName"])
    if idx_old is not None:
        team_chains[idx_old].append(rename["NewName"])
    else:
        team_chains.append([rename["OriginalName"], rename["NewName"]])

with codecs.open('teams.txt', 'w+', 'utf-8') as f:
    f.writelines('\n'.join([','.join(x) for x in team_chains]))

