workspace "LearnEngine"		-- ָ���ǽ������
	
	architecture "x64"

	configurations
	{
		"Debug",	
		"Release",
		"Dist"	-- ���а汾,�޳���־�ȹ���
	}
	
	
outputdir = "%{cfg.buildcfg}-%{cfg.system}-%{cfg.architecture}"

-- ���GLFW�������ļ�
IncludeDir = {}
IncludeDir["GLFW"] = "Hazel/vendor/GLFW/include"
IncludeDir["Glad"] = "Hazel/vendor/Glad/include"
IncludeDir["Imgui"] = "Hazel/vendor/imgui"

include "Hazel/Vendor/GLFW"
include "Hazel/Vendor/Glad"
include "Hazel/Vendor/imgui"

project "Hazel"
	location "Hazel" -- Hazel�����Ŀ�ĵ�ַ
	kind "SharedLib" -- ��̬��
	language "C++"	 

	targetdir("bin/" .. outputdir .. "/%{prj.name}")	-- �������ļ����Ŀ¼
	objdir("bin-int/" .. outputdir .. "/%{prj.name}")-- obj �ļ����Ŀ¼

	-- Ԥ����ͷ�ļ�:
	pchheader "hzpch.h"
	pchsource "Hazel/src/hzpch.cpp"

	-- �����ļ��б�
	files
	{
		"%{prj.name}/src/**.h",	-- �����ǺŽ���ݹ������ļ������ļ�
		"%{prj.name}/src/**.cpp"
	}

	-- ���Ӱ���Ŀ¼
	includedirs
	{
		"%{prj.name}/src",
		"%{prj.name}/vendor/spdlog/include",
		"%{IncludeDir.GLFW}",
		"%{IncludeDir.Glad}",
		"%{IncludeDir.Imgui}"
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
		cppdialect "C++17"
		staticruntime "On"	-- ��̬��������ʱ�Ŀ�
		systemversion "latest"	--ָ��windows SDK�汾
		
		defines
		{
			"HZ_PLATFORM_WINDOWS",
			"HZ_BUILD_DLL",
			"GLFW_INCLUDE_NONE"
		}

		-- �Զ����dll
		postbuildcommands
		{
			-- ����Hazel.dll �� SandboxĿ¼��
			("{COPY} %{cfg.buildtarget.relpath} ../bin/" .. outputdir .. "/Sandbox")
		}

	filter "configurations:Debug"
		defines "HZ_DEBUG"
		buildoptions "/MDd"
		symbols "On"

	filter "configurations:Release"
		defines "HZ_RELEASE"
		buildoptions "/MD"
		optimize "On"

	filter "configurations:Dist"
		defines "HZ_DIST"
		buildoptions "/MD"
		optimize "On"

project "Sandbox"
	location "Sandbox" -- Hazel�����Ŀ�ĵ�ַ
	kind "ConsoleApp" -- ��̬��
	language "C++"	 

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
		"Hazel/src"
	}

	-- �� Hazel �� Sandbox ��������
	links
	{
		"Hazel"
	}

	filter "system:windows"	-- ������.ֱ����һ��������֮�䶼�����������ִ�е�����
		cppdialect "C++17"
		staticruntime "On"	-- ��̬��������ʱ�Ŀ�
		systemversion "latest"	--ָ��windows SDK�汾
		
		defines
		{
			"HZ_PLATFORM_WINDOWS"
		}

		

	filter "configurations:Debug"
		defines "HZ_DEBUG"
		buildoptions "/MDd"
		symbols "On"

	filter "configurations:Release"
		defines "HZ_RELEASE"
		buildoptions "/MD"
		optimize "On"

	filter "configurations:Dist"
		defines "HZ_DIST"
		buildoptions "/MD"
		optimize "On"