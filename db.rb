# frozen_string_literal: true

require 'sqlite3'

DB_PATH = './data.db'

class Db
  # DBへのコネクタ開く
  def initialize
    exists_flg = File.exist?(DB_PATH)
    @db_connector = SQLite3::Database.new(DB_PATH)
    create_table unless exists_flg
  end

  # テーブル作成
  def create_table
    sqls = "
      CREATE TABLE `servers` (
        `id` INTEGER NOT NULL,
        `server_id` TEXT NOT NULL,
        `created_datetime` TIMESTAMP DEFAULT (datetime(CURRENT_TIMESTAMP,'localtime')),
        PRIMARY KEY(`id`)
      );
      CREATE TABLE `channels` (
        `channel_id`	INTEGER NOT NULL,
        `server_id`	INTEGER NOT NULL,
        `channel_type_id`	INTEGER NOT NULL,
        `created_datetime` TIMESTAMP DEFAULT (datetime(CURRENT_TIMESTAMP,'localtime')),PRIMARY KEY(`channel_id`)
      );
      CREATE TABLE `channel_type` (
        `id`	INTEGER NOT NULL,
        `type`	TEXT NOT NULL,
        PRIMARY KEY(`id`)
      );
      INSERT INTO `channel_type`(`id`,`type`) VALUES (1,'INFORM_CHANNEL_ID');
    ".split(';')

    sqls.slice(0, sqls.size - 1).each do |sql|
      sql = sql.gsub!("\n", '')
      update_execute(sql)
    end
  end

  # 更新系クエリ実行
  def update_execute(query)
    @db_connector.execute(query)
  end

  # 取得系クエリ実行
  def get_execute(query)
    @db_connector.execute(query)
  end
end

db = Db.new
