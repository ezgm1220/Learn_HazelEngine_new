#pragma once

#include "Hazel/Renderer/PrespectiveCamera.h"
#include "Hazel/Core/Timestep.h"

#include "Hazel/Events/ApplicationEvent.h"
#include "Hazel/Events/MouseEvent.h"

const glm::vec3 CAMERA_UP(0.0f, 1.0f, 0.0f);
const float SPEED = 2.5f;
const float SENSITIVITY = 0.05f;

namespace Hazel {

	class PrespectiveCameraController
	{
	public:
		PrespectiveCameraController(float aspectRatio, glm::vec3 Pos = glm::vec3(0.0f, 0.0f, 0.0f));

		void OnUpdate(Timestep ts);
		void OnEvent(Event& e);

		PrespectiveCamera& GetCamera() { return m_Camera; }
		const PrespectiveCamera& GetCamera() const { return m_Camera; }

		void SetCamera();

	private:
		bool OnWindowResized(WindowResizeEvent& e);
		bool OnMouseScrolled(MouseScrolledEvent& e);
		bool OnMouseMoved(MouseMovedEvent& e);
	private:
		PrespectiveCamera m_Camera;

		glm::vec3 m_CameraPosition;
		float MovementSpeed, MouseSensitivity;
		float m_fov;
		float m_AspectRatio;
		glm::vec2 LastMousePos;
	};

}