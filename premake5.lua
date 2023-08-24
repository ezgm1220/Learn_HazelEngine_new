workspace "LearnEngine"		-- ָ���ǽ������
	
	architecture "x64"

	configurations
	{
		"Debug",	
		"Release",
		"Dist"	-- ���а汾,�޳���־�ȹ���
	}
	
require "export-compile-commands"


outputdir = "%{cfg.buildcfg}-%{cfg.system}-%{cfg.architecture}"

-- ���GLFW�������ļ�
IncludeDir = {}
IncludeDir["GLFW"] = "Hazel/vendor/GLFW/include"
IncludeDir["Glad"] = "Hazel/vendor/Glad/include"
IncludeDir["Imgui"] = "Hazel/vendor/imgui"
IncludeDir["glm"] = "Hazel/vendor/glm"
IncludeDir["stb_image"] = "Hazel/vendor/stb_image"

include "Hazel/Vendor/GLFW"
include "Hazel/Vendor/Glad"
include "Hazel/Vendor/imgui"


project "Hazel"
	location "Hazel" -- Hazel�����Ŀ�ĵ�ַ
	kind "StaticLib" -- ��̬��/�ĳɾ�̬����
	language "C++"	 
	cppdialect "C++17"
	staticruntime "on"

	targetdir("bin/" .. outputdir .. "/%{prj.name}")	-- �������ļ����Ŀ¼
	objdir("bin-int/" .. outputdir .. "/%{prj.name}")-- obj �ļ����Ŀ¼

	-- Ԥ����ͷ�ļ�:
	pchheader "hzpch.h"
	pchsource "Hazel/src/hzpch.cpp"

	-- �����ļ��б�
	files
	{
		"%{prj.name}/src/**.h",	-- �����ǺŽ���ݹ������ļ������ļ�
		"%{prj.name}/src/**.cpp",
		"%{prj.name}/vendor/stb_image/**.h",
		"%{prj.name}/vendor/stb_image/**.cpp",
		"%{prj.name}/vendor/glm/glm/**.hpp",
		"%{prj.name}/vendor/glm/glm/**.inl"
	}

	defines
	{
		"_CRT_SECURE_NO_WARNINGS"
	}

	-- ���Ӱ���Ŀ¼
	includedirs
	{
		"%{prj.name}/src",
		"%{prj.name}/vendor/spdlog/include",
		"%{IncludeDir.GLFW}",
		"%{IncludeDir.Glad}",
		"%{IncludeDir.Imgui}",
		"%{IncludeDir.glm}",
		"%{IncludeDir.stb_image}"
	}

	-- ���ӵĶ���
	links
	{
		"GLFW",
		"Glad",
		"Imgui",
		"opengl32.lib"
	}

	filter "system:windows"	-- ������.ֱ����һ��������֮�䶼�����������ִ�е�����
		systemversion "latest"	--ָ��windows SDK�汾
		
		defines
		{
			"HZ_PLATFORM_WINDOWS",
			"HZ_BUILD_DLL",
			"GLFW_INCLUDE_NONE",
			"HZ_DEBUG"
		}



	filter "configurations:Debug"
		defines "HZ_DEBUG"
		runtime "Debug"
		symbols "On"

	filter "configurations:Release"
		defines "HZ_RELEASE"
		runtime "Release"
		optimize "On"

	filter "configurations:Dist"
		defines "HZ_DIST"
		runtime "Release"
		optimize "On"
project "Sandbox"
	location "Sandbox" -- Hazel�����Ŀ�ĵ�ַ
	kind "ConsoleApp" -- ��̬��
	cppdialect "C++17"
	language "C++"	 
	staticruntime "on"

	targetdir("bin/" .. outputdir .. "/%{prj.name}")	-- �������ļ����Ŀ¼
	objdir("bin-int/" .. outputdir .. "/%{prj.name}")-- obj �ļ����Ŀ¼

	-- �����ļ��б�
	files
	{
		"%{prj.name}/src/**.h",	-- �����ǺŽ���ݹ������ļ������ļ�
		"%{prj.name}/src/**.cpp"
	}

	-- ���Ӱ���Ŀ¼
	includedirs
	{
		"Hazel/vendor/spdlog/include",
		"Hazel/src",
		"%{IncludeDir.glm}",
		"Hazel/vendor"
	}

	-- �� Hazel �� Sandbox ��������
	links
	{
		"Hazel"
	}

	filter "system:windows"	-- ������.ֱ����һ��������֮�䶼�����������ִ�е�����
		systemversion "latest"	--ָ��windows SDK�汾
		
		defines
		{
			"HZ_PLATFORM_WINDOWS"
		}

		

	filter "configurations:Debug"
		defines "HZ_DEBUG"
		runtime "Debug"
		symbols "On"

	filter "configurations:Release"
		defines "HZ_RELEASE"
		runtime "Release"
		optimize "On"

	filter "configurations:Dist"
		defines "HZ_DIST"
		runtime "Release"
		optimize "On"