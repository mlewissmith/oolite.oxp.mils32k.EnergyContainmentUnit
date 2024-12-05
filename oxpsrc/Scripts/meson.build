fs = import('fs')

infiles = [
  'ShieldBoosterECU.js.in',
  'EQ_ECU_SHIELD_BOOSTER_LICENCE.js.in',
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
