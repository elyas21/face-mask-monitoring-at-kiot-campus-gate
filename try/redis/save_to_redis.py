import redis

r = redis.Redis(host='localhost', port=6379)

for j in [0,1]:
    print(j)
    [r.sadd('list_me'+str(j), i) for i in [1,24,3,4353,353,532,52,35,325,]]
# r.smembers('list_me3'q)