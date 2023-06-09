class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    can :read, :all # users can read everything
    return unless user.present?

    can :create, Post
    can :destroy, Post, author_id: user.id # logged users can destroy their own posts
    can :destroy, Comment, author_id: user.id # logged users can manage their own comments
    can :create, Comment # logged users can create comments

    return unless user.admin?

    can :destroy, :all # admin can detroy any post
  end
end
