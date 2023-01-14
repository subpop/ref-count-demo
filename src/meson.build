ref_count_demo_sources = [
  'main.vala',
]

ref_count_demo_deps = [
  dependency('glib-2.0'),
  dependency('gobject-2.0'),
]

executable('ref-count-demo', ref_count_demo_sources,
  vala_args: '--target-glib=2.58',  dependencies: ref_count_demo_deps,
  install: true,
)

