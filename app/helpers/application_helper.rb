# Модуль хэлпера ApplicationHelper
#
# В этом файле мы можем писать вспомогательные методы (хелперы) для шаблонов,
# (представлений, вьюх) нашего приложения
module ApplicationHelper
  # Этот метод возвращает ссылку на автарку пользователя, если она у него есть
  # или ссылку на дефолтную аватарку, которая лежит в app/assets/images
  def user_avatar(user)
    if user.avatar_url.present?
      user.avatar_url
    else
      asset_path 'avatar.jpg'
    end
  end

  # Хелпер, рисующий span тэг с иконкой из font-awesome
  def fa_icon(icon_class)
    content_tag 'span', '', class: "fa fa-#{icon_class}"
  end

  def sklonenie(number, krokodil, krokodila, krokodilov)

    if (number % 100) >= 11 && (number % 100) <= 14
      return krokodilov
    end

    ostatok = number % 10

    if ostatok == 1
      return krokodil
    end
    if ostatok >= 2 && ostatok <= 4
      return krokodila
    end
    if ostatok > 4 || ostatok == 0
      return krokodilov
    end
  end
end

