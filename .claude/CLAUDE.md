# pra-proxmox

Proxmox, Terraform, cloud-init, Ansibleの練習用プロジェクトである。

## 目的

- LXC上でStrapiをホスティングする
- ZFSやバックアップサーバを用いたバックアップの手法を学ぶ

## 構成
- Proxmoxのホストにはtailscale経由でssh接続できる
  - `ssh proxmox`でアクセスできる
  - nyantamaユーザでログインし、sudo権限を持っている
- ローカルサブネットとTailnetサブネットが競合しているため、LXCへの直接SSH接続はできない
  - LXCへの操作は `pct exec` コマンドを使用する
  - Ansibleは `community.general.proxmox` コネクションプラグインで接続する
