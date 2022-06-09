Pod::Spec.new do |spec|

  spec.name         = "HLTimeKeeper"
  spec.version      = "1.0.0"
  spec.summary      = "iOS计时器，可用于电商cell倒计时等"

  # 描述
  spec.description  = <<-DESC
      iOS计时器，可用于电商cell倒计时等，前后台切换计时准确。
  DESC

  # 项目主页
  spec.homepage     = "https://github.com/huangchangweng/HLTimeKeeper"
 
  # 开源协议
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  
  # 作者
  spec.author       = { "黄常翁" => "599139419@qq.com" }
  
  # 支持平台
  spec.platform     = :ios, "9.0"

  # git仓库，tag
  spec.source       = { :git => "https://github.com/huangchangweng/HLTimeKeeper.git", :tag => spec.version.to_s }

  # 资源路径
  spec.source_files  = "HLTimeKeeper/HLTimeKeeper/*.{h,m}"

  # 依赖系统库
  spec.frameworks = "UIKit"

end
