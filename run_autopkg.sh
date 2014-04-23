#!/bin/bash
#
# Mount munki_repo, run autopkg recipes and make catalogs.
# 
# To include more recipes/repos, add the new name to the recipes[]/repos[] array(s).
#
# Derak Berreyesa
# github.com/derak
##################################

declare -a recipes=( \

        "AdobeFlashPlayer.munki" \
        "Firefox.munki" \
        "GoogleChrome.munki" \
        "HipChat.munki" \
        "MSOffice2011Updates.munki" \
        "munkitools.munki" \
        "OracleJava7.munki" \
        "TextWrangler.munki" \
        "MakeCatalogs.munki" \
)

declare -a repos=( \

        "https://github.com/autopkg/recipes.git" \
        "https://github.com/autopkg/derak-recipes.git" \
)

# mount nfs munki_repo
mkdir /Volumes/deploy
mount -o rw,bg,hard,resvport,intr,noac,nfc,tcp munki_server.example.com:/deploy /Volumes/deploy/

# update autopkg recipes
sudo -u user_who_has_munki_access autopkg repo-add ${repos[@]}
# run autopkg
sudo -u user_who_has_munki_access autopkg run -v ${recipes[@]}

# no need to call makecatalogs, the MakeCatalogs.munki recipe will do this if necessary
#makecatalogs

umount /Volumes/deploy

echo "finished."
