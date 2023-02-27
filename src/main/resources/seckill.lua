-- 1�������б�
-- 1��1 �Ż�ȯid
local voucherId = ARGV[1]
-- 1��2 �û�id
local userId = ARGV[2]
-- 1��3 ����id
local orderId = ARGV[3]

-- 2������key
-- 2��1 ���key
local stockKey = 'seckill:stock:' .. voucherId
-- 2��2 ����key
local orderKey = 'seckill:order:' .. voucherId

-- 3���ű�ҵ��
-- 3��1 �жϿ���Ƿ���� get stockKey
if(tonumber(redis.call('get', stockKey))  <= 0) then
    -- ��治�㣬����1
    return 1
end
-- 3��2 �ж��û��Ƿ��µ� SISMEMBER orderkey userId
if(redis.call('SISMEMBER', orderKey, userId) == 1) then
    -- ���ڣ�˵�����ظ��µ�������2
    return 2
end

-- 3��4 �ۿ�� incrby stockKey -1
redis.call('incrby', stockKey, -1);
-- 3��5 �µ��������û��� sadd orderkey userId
redis.call('sadd', orderKey, userId)
-- 3��6 ������Ϣ�������� XADD stream.orders * k1 v1 k2 v2
redis.call('xadd', 'stream.orders', '*', 'userId', userId, 'voucherId', voucherId, 'id', orderId)

return 0

