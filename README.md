# AzureSynapseNotes



# 循环表与复制的表的查询性能对比示例
复制的表不要求为联接移动任何数据，因为整个表已存在于每个计算节点上。 如果维度表是循环分布式的，则联接会将维度表整个复制到每个计算节点。 为了移动数据，查询计划包含了一个名为 BroadcastMoveOperation 的操作。 此类数据移动操作会降低查询性能，使用复制的表可以避免。 若要查看查询计划步骤，请使用 sys.dm_pdw_request_steps 系统目录视图。

例如，在针对 AdventureWorks 架构的以下查询中，FactInternetSales 表是哈希分布表。 DimDate 和 DimSalesTerritory 表是较小的维度表。 此查询返回 2004 会计年度在北美的总销售额：

以下查询使用 sys.pdw_replicated_table_cache_state DMV 列出已修改但未重新生成的复制的表。
```sql
SELECT [ReplicatedTable] = t.[name]
  FROM sys.tables t  
  JOIN sys.pdw_replicated_table_cache_state c  
    ON c.object_id = t.object_id
  JOIN sys.pdw_table_distribution_properties p
    ON p.object_id = t.object_id
  WHERE c.[state] = 'NotReady'
    AND p.[distribution_policy_desc] = 'REPLICATE'

```