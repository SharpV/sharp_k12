#encoding: utf-8

module Role
  
  def role_name
    case role
    when 'teacher' then '老师'
    when 'student' then '学生'
    when 'parent' then '家长'
    end   
  end

  def teacher?
    role == 'teacher'
  end

  def parent?
    role == 'parent'
  end

  def student?
    role == 'student'
  end
  
end