fn_material() {
  ################
  # This script creates all icons in src/lib directory.
  ######################
  GITURL="git@github.com:Templarian/MaterialDesign.git"
  DIRNAME='MaterialDesign'
  SVGDIR='svg'
  LOCAL_REPO_NAME="$HOME/Svelte/SVELTE-ICON-FAMILY/svelte-materialdesign-icons"
  SVELTE_LIB_DIR='src/lib'
  CURRENTDIR="${LOCAL_REPO_NAME}/${SVELTE_LIB_DIR}"
  
  if [ ! -d ${CURRENTDIR} ]; then
    mkdir ${CURRENTDIR} || exit 1
  else
    bannerColor "Removing the previous ${CURRENTDIR} dir." "blue" "*"
    rm -rf "${CURRENTDIR:?}/"
    # create a new
    mkdir -p "${CURRENTDIR}"
  fi
  
  cd "${CURRENTDIR}" || exit 1

  # clone the repo
  bannerColor "Cloning ${DIRNAME}." "green" "*"
  git clone "${GITURL}" >/dev/null 2>&1 || {
    echo "not able to clone"
    exit 1
  }

  # copy svgs dir from the cloned dir
  bannerColor 'Moving svgs dir to the root.' "green" "*"
  if [ -d "${CURRENTDIR}/${SVGDIR}" ]; then
    bannerColor 'Removing the previous svgs dir.' "blue" "*"
    rm -rf "${CURRENTDIR}/${SVGDIR}"
  fi

  mv "${CURRENTDIR}/${DIRNAME}/${SVGDIR}" "${CURRENTDIR}"

  bannerColor "Changing dir to ${SVGDIR}" "blue" "*"
  cd "${CURRENTDIR}/${SVGDIR}" || exit

  # For each svelte file modify contents of all file by
  bannerColor 'Modifying all files.' "blue" "*"

  # removing <?xml version="1.0" encoding="UTF-8"?><!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.1//EN" "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd">
  sed -i 's;<?xml version="1.0" encoding="UTF-8"?><!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.1//EN" "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd">;;' ./*.*

  # removing width="24" height="24"
  sed -i 's/width="24" height="24"//' ./*.*

  # inserting script tag at the beginning and insert width={size} height={size} class={$$props.class}
  sed -i '1s/^/<script>export let size="24"; export let color="currentColor";<\/script>/' ./*.* && sed -i 's/viewBox=/width={size} height={size} fill={color} class={$$props.class} {...$$restProps} aria-label={ariaLabel} on:click on:mouseenter on:mouseleave on:mouseover on:mouseout on:blur on:focus &/' ./*.*

  # get textname from filename
  for filename in "${CURRENTDIR}/${SVGDIR}"/*; do
    FILENAME=$(basename "${filename}" .svg | tr '-' ' ')
    # echo "${FILENAME}"
    sed -i "s;</script>;export let ariaLabel=\"${FILENAME}\" &;" "${filename}"
  done

  #  modify file names
  bannerColor 'Renaming all files in the dir.' "blue" "*"

  # rename files with number at the beginning with A
  rename -v 's{^\./(\d*)(.*)\.svg\Z}{
    ($1 eq "" ? "" : "A$1") . ($2 =~ s/\w+/\u$&/gr =~ s/-//gr) . ".svelte"
  }ge' ./*.svg >/dev/null 2>&1

  bannerColor 'Renaming is done.' "green" "*"

  bannerColor 'Modification is done in the dir.' "green" "*"

  # Move all files to lib dir
  mv ./* "${CURRENTDIR}"

  #############################
  #    INDEX.JS PART 1 IMPORT #
  #############################
  cd "${CURRENTDIR}" || exit 1

  bannerColor 'Creating index.js file.' "blue" "*"
  
  find . -type f -name '*.svelte' | sort | awk -F'[/.]' '{
    print "export { default as " $(NF-1) " } from \047" $0 "\047;"
  }' >index.js

  bannerColor 'Added export to index.js file.' "green" "*"

  # clean up
  rm -rf "${CURRENTDIR}/${DIRNAME}"
  rm -rf "${CURRENTDIR}/${SVGDIR}"

  bannerColor 'All done.' "green" "*"

  bannerColor 'All icons are created in the src/lib directory.' 'magenta' '='
}
