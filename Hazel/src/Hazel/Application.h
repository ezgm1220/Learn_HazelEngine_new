#pragma once

#include "Core.h"
#include <cstdio>

namespace Hazel {

	class HAZEL_API Application
	{
	public:
		Application();
		virtual ~Application();
		void Run();
	};

	Application* CreatApplication();

}