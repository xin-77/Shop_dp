

-- �Ƚ��̱߳�ʶ�����еı�ʶ�Ƿ�һ��
if(redis.call('GET', KEYS[1]) == ARGV[1]) then
    -- �ͷ��� del key
    return redis.call('DEL', KEYS[1])
end
return 0
