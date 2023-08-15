workspace "LearnEngine"		-- 指的是解决方案
	
	architecture "x64"

	configurations
	{
		"Debug",	
		"Release",
		"Dist"	-- 发行版本,剔除日志等功能
	}
	

outputdir = "%{cfg.buildcfg}-%{cfg.system}-%{cfg.architecture}"

project "Hazel"
	location "Hazel" -- Hazel这个项目的地址
	kind "SharedLib" -- 动态库
	language "C++"	 

	targetdir("bin/" .. outputdir .. "/%{prj.name}")	-- 二进制文件输出目录
	objdir("bin-int/" .. outputdir .. "/%{prj.name}")-- obj 文件输出目录

	-- 包含文件列表
	files
	{
		"%{prj.name}/src/**.h",	-- 两个星号将会递归搜索文件夹子文件
		"%{prj.name}/src/**.cpp"
	}

	-- 附加包含目录
	includedirs
	{
		"%{prj.name}/src",
		"%{prj.name}/vendor/spdlog/include"
	}

	filter "system:windows"	-- 过滤器.直到下一个过滤器之间都是这个过滤器执行的内容
		cppdialect "C++17"
		staticruntime "On"	-- 静态链接运行时的库
		systemversion "latest"	--指定windows SDK版本
		
		defines
		{
			"HZ_PLATFORM_WINDOWS",
			"HZ_BUILD_DLL"
		}

		-- 自动添加dll
		postbuildcommands
		{
			-- 拷贝Hazel.dll 到 Sandbox目录中
			("{COPY} %{cfg.buildtarget.relpath} ../bin/" .. outputdir .. "/Sandbox")
		}

	filter "configurations:Debug"
		defines "HZ_DEBUG"
		symbols "On"

	filter "configurations:Release"
		defines "HZ_RELEASE"
		optimize "On"

	filter "configurations:Dist"
		defines "HZ_DIST"
		optimize "On"

project "Sandbox"
	location "Sandbox" -- Hazel这个项目的地址
	kind "ConsoleApp" -- 动态库
	language "C++"	 

	targetdir("bin/" .. outputdir .. "/%{prj.name}")	-- 二进制文件输出目录
	objdir("bin-int/" .. outputdir .. "/%{prj.name}")-- obj 文件输出目录

	-- 包含文件列表
	files
	{
		"%{prj.name}/src/**.h",	-- 两个星号将会递归搜索文件夹子文件
		"%{prj.name}/src/**.cpp"
	}

	-- 附加包含目录
	includedirs
	{
		"Hazel/vendor/spdlog/include",
		"Hazel/src"
	}

	-- 将 Hazel 和 Sandbox 链接起来
	links
	{
		"Hazel"
	}

	filter "system:windows"	-- 过滤器.直到下一个过滤器之间都是这个过滤器执行的内容
		cppdialect "C++17"
		staticruntime "On"	-- 静态链接运行时的库
		systemversion "latest"	--指定windows SDK版本
		
		defines
		{
			"HZ_PLATFORM_WINDOWS"
		}

		

	filter "configurations:Debug"
		defines "HZ_DEBUG"
		symbols "On"

	filter "configurations:Release"
		defines "HZ_RELEASE"
		optimize "On"

	filter "configurations:Dist"
		defines "HZ_DIST"
		optimize "On"