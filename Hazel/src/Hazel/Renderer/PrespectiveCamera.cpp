#include "hzpch.h"
#include "PrespectiveCamera.h"
#include "Hazel/Core/Input.h"

#include <glm/gtc/matrix_transform.hpp>

namespace Hazel {

	PrespectiveCamera::PrespectiveCamera(glm::vec3 position , glm::vec3 up ,float aspect) 
		: Front(glm::vec3(0.0f, 0.0f, -1.0f)), Fov(FOV)
	{
		m_Position = position;
		WorldUp = up;
		Theta = THETA;
		Phi = PHI;
		CameraNearPlane = NEARPLANE;
		CameraFarPlane = FARPLANE;
		AspectRatio = aspect;
		m_ProjectionMatrix = glm::mat4(1);
		m_ViewMatrix = glm::mat4(1);
		updateCameraVectors();
		RecalculateProjection();
		RecalculateLookAt();
		RecalculateViewMatrix();
	}

	void PrespectiveCamera::RecalculateProjection()
	{
		m_ProjectionMatrix = glm::perspective(glm::radians(Fov), AspectRatio, CameraNearPlane, CameraFarPlane);
	}
	void PrespectiveCamera::RecalculateLookAt()
	{
		m_ViewMatrix = glm::lookAt(m_Position, m_Position + Front, Up);
	}

	void PrespectiveCamera::RecalculateViewMatrix()
	{
		m_ViewProjectionMatrix = m_ProjectionMatrix * m_ViewMatrix;
	}

	void PrespectiveCamera::updateCameraVectors()
	{
		// calculate the new Front vector
		glm::vec3 front;
		//double a = glm::radians(Yaw), b = cos(glm::radians(Yaw));
		front.x = sin(glm::radians(Theta)) * sin(glm::radians(Phi));
		front.y = cos(glm::radians(Theta));
		front.z = sin(glm::radians(Theta)) * cos(glm::radians(Phi));
		Front = glm::normalize(front);
		// also re-calculate the Right and Up vector
		Right = glm::normalize(glm::cross(Front, WorldUp));  // normalize the vectors, because their length gets closer to 0 the more you look up or down which results in slower movement.
		Up = glm::normalize(glm::cross(Right, Front));

	}

}