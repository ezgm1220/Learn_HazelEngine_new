#pragma once

#ifdef HZ_PLATFORM_WINDOWS

extern Hazel::Application* Hazel::CreatApplication();

int main(int argc, char** argv) 
{
	Hazel::Log::Init();// ��ʼ����־ϵͳ
	//������main()�г�ʼ����־ϵͳ�ᱻ������App��,������Ľ�

	auto app = Hazel::CreatApplication();

	app->Run();

	delete app;
}

#endif
