class StudentMailer < ApplicationMailer

  def verification_email(student)
    @student = student
    mail(to: @student.email, subject: 'Verified!!')
  end

  def creation_email(student)
    @student = student
    mail(to: @student.email, subject: 'Welcome')
  end
end
