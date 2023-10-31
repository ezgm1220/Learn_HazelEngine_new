#pragma once

#include "Hazel/Core/Core.h"

#include "Hazel/Core/Window.h"
#include "Hazel/Core/LayerStack.h"
#include "Hazel/Events/Event.h"
#include "Hazel/Events/ApplicationEvent.h"
#include "Hazel/Core/Timestep.h"
#include "Hazel/ImGui/ImGuiLayer.h"

namespace Hazel {

	class Application
	{
	public:
		Application();
		virtual ~Application();

		void Run();

		void OnEvent(Event& e);

		void PushLayer(Layer* layer);
		void PushOverlay(Layer* layer); 

		// ���ش�������
		inline Window& GetWindow() { return *m_Window; }
		inline static Application& Get() { return *s_Instance; }
	private:
		// ���ڹرմ�����
		bool OnWindowClose(WindowCloseEvent& e);
		// ���ڴ�С������
		bool OnWindowResize(WindowResizeEvent& e);
	private:
		std::unique_ptr<Window> m_Window;
		ImGuiLayer* m_ImGuiLayer;
		bool m_Running = true;
		bool m_Minimized = false;
		LayerStack m_LayerStack;
		Timestep m_Timestep;
		float m_lastFrameTime = 0.0f;
	private:
		static Application* s_Instance;// ʹ�õ���ģʽ

	};

	Application* CreateApplication();

}