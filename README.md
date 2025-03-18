# Nodayama Peripheral Communicate Protocols (NPCPs)

Nodayama Peripheral Communicate
Protocols(以下、NPCPs)は、IC間通信の方式によるパケットサイズ制限などを吸収し、データ転送を容易にする事を目的とした通信プロトコル群である。

## プロトコル一覧

NPCPsにおけるプロトコルとその役割の表を以下に示す。

|                プロトコル名                 | 役割                                       |
| :-----------------------------------------: | :----------------------------------------- |
| Nodayama Low-layer Transfer Protocol (NLTP) | 固定長(8バイト)のデータ転送を提供する      |
|   Nodayama Data Transfer Protocol (NDTP)    | チェックサム・任意長のデータ転送を提供する |

## 仕様一覧

### Nodayama Low-layer Transfer Protocol (NLTP)

- [Draft 2025-03](nltp/draft-2025-03.md)

### Nodayama Data Transfer Protocol (NDTP)

- [Draft 2025-03](ndtp/draft-2025-03.md)

#### 別紙

- [プロトコル番号一覧](ndtp/protocol-id.md)
