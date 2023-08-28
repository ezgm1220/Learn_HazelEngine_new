#pragma once

#include <glm/glm.hpp>

const float THETA = 90.0f;
const float PHI = 0.0f;
const float FOV = 45.0f;
const float NEARPLANE = 0.1f;
const float FARPLANE = 100.0f;

namespace Hazel {

	class PrespectiveCamera
	{
	public:
		PrespectiveCamera(glm::vec3 position , glm::vec3 up , float aspect);
		
		const glm::vec3& GetPosition() const { return m_Position; }
		void SetPosition(const glm::vec3& position) { m_Position = position; }

		float GetFov() { return Fov; }
		void SetFov(float fov) { Fov = fov;}

		glm::vec2 GetAngle() { return { Theta,Phi }; }
		void SetAngle(glm::vec2 angle) { Theta = angle.x; Phi = angle.y; updateCameraVectors(); }

		void SetViewProjectionMatrix() { RecalculateViewMatrix(); }
		void SetAspectRatio(float ratio) { AspectRatio = ratio; }

		glm::vec3 GetFront() { return Front; }
		glm::vec3 GetRight() { return Right; }

		const glm::mat4& GetProjectionMatrix() const { return m_ProjectionMatrix; }
		const glm::mat4& GetViewMatrix() const { return m_ViewMatrix; }
		const glm::mat4& GetViewProjectionMatrix() const { return m_ViewProjectionMatrix; }

		void SetCamera() { RecalculateProjection(); RecalculateLookAt(); RecalculateViewMatrix();}

		//const 
	protected:
		void RecalculateProjection();
		void RecalculateLookAt();
		void RecalculateViewMatrix();
		void updateCameraVectors();
	private:
		glm::mat4 m_ProjectionMatrix;
		glm::mat4 m_ViewMatrix;
		glm::mat4 m_ViewProjectionMatrix;

		glm::vec3 m_Position = { 0.0f, 0.0f, 0.0f };
		glm::vec3 Front, Up, Right, WorldUp;
		float Theta, Phi;
		float Fov;
		float CameraNearPlane, CameraFarPlane;
		float AspectRatio;
		float m_Rotation = 0.0f;
	};

}