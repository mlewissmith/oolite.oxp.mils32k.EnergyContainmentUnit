fs = import('fs')

infiles = [
  'world-scripts.plist.in',
  'equipment.plist.in',
  'ForwardWeaponECU.crosshairs.plist.in',
]

foreach infile : infiles
  if infile.endswith('.in')
    outfile = fs.stem(infile)
  else
    outfile = fs.name(infile)
  endif
  oxp_file = configure_file(
    input         : infile,
    output        : outfile,
    configuration : oxp_cfg_data,
  )
  oxp_files += oxp_file
endforeach

