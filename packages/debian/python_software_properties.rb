package :python_software_properties do
  description 'Manage the repositories that you install software from'
  apt 'python-software-properties'

  verify do
    has_apt 'python-software-properties'
  end
end
