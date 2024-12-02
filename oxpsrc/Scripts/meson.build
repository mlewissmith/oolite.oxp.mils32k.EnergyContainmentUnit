fs = import('fs')

infiles = [
  'world_ShieldBoosterECU.js.in',
  'equip_ShieldBoosterECU_Licence.js.in',
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
