#pragma once

#ifdef HZ_PLATFORM_WINDOWS

extern Hazel::Application* Hazel::CreatApplication();

int main(int argc, char** argv) {

	Hazel::Log::Init();// 初始化日志系统
	//但是再main()中初始化日志系统会被包含在App中,后续会改进

	HZ_CORE_WARN("CORE WARN");
	HZ_CORE_INFO("Var = {0}{2}{1}", 5, 1, 3);
	HZ_CORE_WARN("CKKKKK");

	auto app = Hazel::CreatApplication();
	app->Run();
	delete app;
}

#endif
