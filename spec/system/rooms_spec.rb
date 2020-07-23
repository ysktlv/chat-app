require 'rails_helper'

RSpec.describe "チャットールームの削除機能", type: :system do
  before do
    @room_user = FactoryBot.create(:room_user)
  end

  it 'チャットルームを削除すると、関連するメッセージがすべて削除されていること' do
    # サインインする
    sign_in(@room_user.user)

    # 作成されたチャットルームへ遷移する
    click_on(@room_user.room.name)

    # メッセージ情報を5つDBに追加する
    FactoryBot.create_list(:message, 5)

    # 「チャットを終了する」ボタンをクリックすることで、作成した5つのメッセージが削除されていることを期待する
    expect(find("チャットを終了する").click).to change { Message.count }.by(-5)

    # ルートページに遷移されることを期待する
    expect(current_path).to eq root_path

  end
end