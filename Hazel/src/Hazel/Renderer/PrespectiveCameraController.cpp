#include "hzpch.h"
#include "PrespectiveCameraController.h"

#include "Hazel/Core/Input.h"
#include "Hazel/Core/KeyCodes.h"

namespace Hazel {

	PrespectiveCameraController::PrespectiveCameraController(float aspectRatio, glm::vec3 Pos)
		:m_AspectRatio(aspectRatio), m_Camera(Pos, CAMERA_UP, aspectRatio), MovementSpeed(SPEED), MouseSensitivity(SENSITIVITY), m_CameraPosition(Pos)
	{

	}

	void PrespectiveCameraController::OnUpdate(Timestep ts)
	{

		if (Input::IsMouseButtonPressed(HZ_MOUSE_BUTTON_RIGHT)) {
			glm::vec3 Front = m_Camera.GetFront();
			glm::vec3 Right = m_Camera.GetRight();

			if (Input::IsKeyPressed(HZ_KEY_A))
				m_CameraPosition -= Right * (MovementSpeed * ts);
			else if (Input::IsKeyPressed(HZ_KEY_D))
				m_CameraPosition += Right * (MovementSpeed * ts);

			if (Input::IsKeyPressed(HZ_KEY_W))
				m_CameraPosition += Front * (MovementSpeed * ts);
			else if (Input::IsKeyPressed(HZ_KEY_S))
				m_CameraPosition -= Front * (MovementSpeed * ts);

		}

		m_Camera.SetPosition(m_CameraPosition);
	}

	void PrespectiveCameraController::OnEvent(Event& e)
	{
		EventDispatcher dispatcher(e);
		dispatcher.Dispatch<WindowResizeEvent>(HZ_BIND_EVENT_FN(PrespectiveCameraController::OnWindowResized));

		dispatcher.Dispatch<MouseScrolledEvent>(HZ_BIND_EVENT_FN(PrespectiveCameraController::OnMouseScrolled));
		dispatcher.Dispatch<MouseMovedEvent>(HZ_BIND_EVENT_FN(PrespectiveCameraController::OnMouseMoved));
		
	}

	bool PrespectiveCameraController::OnMouseScrolled(MouseScrolledEvent& e)
	{
		float fov = m_Camera.GetFov();
		fov -= e.GetYOffset();
		if (fov < 1.0f)
			fov = 1.0f;
		if (fov > 45.0f)
			fov = 45.0f;
		m_Camera.SetFov(fov);
		return false;
	}

	bool PrespectiveCameraController::OnWindowResized(WindowResizeEvent& e)
	{
		m_AspectRatio = (float)e.GetWidth() / (float)e.GetHeight();
		m_Camera.SetAspectRatio(m_AspectRatio);
		return false;
	}

	bool PrespectiveCameraController::OnMouseMoved(MouseMovedEvent& e) {

		return false;
	}

	void PrespectiveCameraController::SetCamera() 
	{
		m_Camera.SetCamera();
	}

}