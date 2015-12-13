#!/bin/bash

ARRAY=('croatia-collaboration' 'india-mandatory-declaration-of-assets' 'slovenia-netherlands-uk-attending' 'us-legislators-meeting-young-people' 'us-removed-rules-for-social-media' 'latvia-proposing-legislation' 'parliaments-transparency-openness' 'montenegro-online-petinioning-system' 'argentina-collaboration-pmos' 'brazil-open-data-standard' 'uk-gov-uk-on-github' 'european-parliament-mark-up-tool' 'european-parliament-live-chats' 'finland-external-groups' 'italy-akoma-ntoso' 'mexico-parliamentary-openness' 'new-zealand-easy-access' 'scotland-key-principles' 'italy-open-data' 'sweden-reaching-citizens' 'sweden-easy-of-use' 'us-standards-electronic-information' 'us-oregon-initiative-review' 'uk-legislation-available' 'uk-agenda-ipad' 'uk-youth-education' 'us-crowdsourcing-platform' 'us-challenge-akoma-ntoso' 'korea-information')

#for NAME in $ARRAY
total=${#ARRAY[*]}
echo $total
for (( i=0; i<=$(( $total -1 )); i++ ))
do
    NAME=${ARRAY[$i]}
    touch ../../legislative-openness-data-explorer-texts/en/best-practices/examples/$NAME.md
    echo  ../../legislative-openness-data-explorer-texts/en/best-practices/examples/$NAME.md
    sleep 1
done
