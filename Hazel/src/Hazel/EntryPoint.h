#pragma once

#ifdef HZ_PLATFORM_WINDOWS

extern Hazel::Application* Hazel::CreatApplication();

int main(int argc, char** argv) {

	Hazel::Log::Init();// ��ʼ����־ϵͳ
	//������main()�г�ʼ����־ϵͳ�ᱻ������App��,������Ľ�

	HZ_CORE_WARN("CORE WARN");
	HZ_CORE_INFO("Var = {0}{2}{1}", 5, 1, 3);
	HZ_CORE_WARN("CKKKKK");

	auto app = Hazel::CreatApplication();
	app->Run();
	delete app;
}

#endif
