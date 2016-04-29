load File.expand_path("../tasks/faster_assets.rake", __FILE__)

set_if_empty :faster_assets_diff, :diff
set_if_empty :faster_assets_cp, :cp
