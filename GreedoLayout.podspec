Pod::Spec.new do |s|
  s.name         = "GreedoLayout"
  s.version      = "0.0.1"
  s.summary      = "Full Aspect Ratio UICollectionView layout"
  s.description  = "Computes what size the UICollectionView cells should be to display images in a variable height fixed aspect ratio grid."
  s.homepage     = "https://github.com/500px/greedo-layout-for-ios"
  s.license      = 'MIT'
  s.author       = { "David Charlec" => "david@500px.com" }
  s.source       = { :git => "git@github.com:500px/greedo-layout-for-ios.git", :tag => "0.0.1" }
  s.platform     = :ios, '6.0'
  s.source_files = '*.{h,m}'
  s.requires_arc = true  
end