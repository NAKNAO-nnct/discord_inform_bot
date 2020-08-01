# frozen_string_literal: true

# ユーザのセッションを管理する
class User
  # 初期化
  def initialize
    @user_status = { 'no_user' => { 'status' => 'offline', 'mute' => 'false' } }
  end

  # userの状態を返す
  def getUserStatus(user_name)
    return @user_status[user_name] if @user_status.key?(user_name)

    { 'status' => 'offline' }
  end

  # userの状態を更新
  def setUserStatus(user_name, status, mute)
    @user_status[user_name] = {} unless @user_status.key?(user_name)
    @user_status[user_name]['status'] = status
    @user_status[user_name]['mute'] = mute.to_s
    # offlineの時は削除
    @user_status.delete(user_name) if status == 'offline'
  end
end
