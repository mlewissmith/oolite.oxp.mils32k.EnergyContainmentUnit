project(
  'oolite.oxp.EnergyContainmentUnit',
  license       : 'UNLICENSE',
  version       : '0.0.5',
)

PROJECT_NAME     = meson.project_name()
PROJECT_VERSION  = meson.project_version()
PROJECT_LICENSE  = meson.project_license().get(0)
PROJECT_TITLE    = 'EnergyContainmentUnit'
PROJECT_AUTHOR   = 'mils32k'
PROJECT_ID       = 'oolite.oxp.' + PROJECT_AUTHOR + '.' + PROJECT_TITLE

oxp_cfg_data = configuration_data(
  {
    'OXP_TITLE'       : PROJECT_TITLE,
    'OXP_DESCRIPTION' : '[TODO]',
    'OXP_AUTHOR'      : PROJECT_AUTHOR,
    'OXP_IDENTIFIER'  : PROJECT_ID,
    'OXP_VERSION'     : PROJECT_VERSION,
    'OXP_LICENSE'     : PROJECT_LICENSE,
    'OXP_OOLITE'      : '1.81',
    'OXP_CATEGORY'    : 'Misc',
    'OXP_INFOURL'     : '[TODO]',
  }
)

################################################################################

oxp_srcdir = 'oxpsrc'
oxp_files = []
subdir(oxp_srcdir)

ZIP_SH = find_program('zip.sh', required : true)
oxz = custom_target(
  'oxz',
  input            : oxp_files,
  output           : oxp_cfg_data.get('OXP_IDENTIFIER') + '.oxz',
  env              : {
                       'ZIP_OPTS'    : '-FS -v',
                       'ZIP_BASEDIR' : oxp_srcdir,
                     },
  command          : [ ZIP_SH, '@OUTPUT@', '@INPUT@' ],
  build_by_default : true,
)

oxz_versioned = custom_target(
  'oxz-versioned',
  input            : oxp_files,
  output           : oxp_cfg_data.get('OXP_IDENTIFIER')
                     + '-' + PROJECT_VERSION
                     + '.oxz',
  env              : {
                       'ZIP_OPTS'    : '-FS -v',
                       'ZIP_BASEDIR' : oxp_srcdir,
                     },
  command          : [ ZIP_SH, '@OUTPUT@', '@INPUT@' ],
  build_by_default : true,
)

################################################################################

verify_oxp = custom_target(
  'verify-oxp',
  output : '.PHONY.verify-oxp',
  command : [ 'head', '-n-0', oxp_files ],
)

verify_oxz = custom_target(
  'verify-oxz',
  output : '.PHONY.verify-oxz',
  command : [ 'unzip', '-l', oxz ],
)

custom_target(
  'verify',
  output  : '.PHONY.verify',
  depends : [ verify_oxp, verify_oxz ],
  command : [ 'true' ],
)
