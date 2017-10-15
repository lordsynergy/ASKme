# Контроллер, управляющий пользователями. Должен уметь:
#
#   1. Показывать страницу пользователя
#   2. Создавать новых пользователей
#   3. Позволять пользователю редактировать свою страницу
#
class UsersController < ApplicationController
  # Это действие отзывается, когда пользователь заходит по адресу /users
  def index
    # Мы создаем массив из двух болванок пользователей. Для создания фейковой
    # модели мы просто вызываем метод User.new, который создает модель, не
    # записывая её в базу.
    @users = [
        User.new(
            id: 1,
            name: 'Georgy',
            username: 'lordsynergy'
        ),
        User.new(id: 2, name: 'Misha', username: 'aristofun')
    ]
  end

  def new
  end

  def edit
  end

  # Это действие отзывается, когда пользователь заходит по адресу /users/:id,
  # например /users/1.
  def show
    # Болванка пользователя
    @user = User.new(
        name: 'Georgy',
        username: 'lordsynergy',
        avatar_url: 'https://sun9-3.userapi.com/c638121/v638121719/5d668/KdV30wVYxxg.jpg'
    )

    # Болванка вопросов для пользователя
    @questions = [
        Question.new(text: 'Как дела?', created_at: Date.parse('27.03.2016')),
        Question.new(
            text: 'В чем смысл жизни?', created_at: Date.parse('27.03.2016')
        )
    ]

    # Болванка для нового вопроса
    @new_question = Question.new

    # Обратите внимание, пока ни одна из болванок не достается из базы
  end
end
