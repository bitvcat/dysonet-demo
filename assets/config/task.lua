--   id                           int        Key
--   name                         string     字符串
--   intVal                       int        定点数
--   boolVal                      bool       布尔值
--   jsonVal                      json       json字符串

return {
    [1] = {
        id = 1,
        name = "test2",
        intVal = 1,
        boolVal = false,
        jsonVal = {
            [1] = 1,
            [2] = 2,
            [3] = 3,
            [4] = 4,
            [5] = 5
        }
    },
    [2] = {
        id = 2,
        name = "aaaxxxxx",
        intVal = 2,
        boolVal = false,
        jsonVal = {
            sites = {
                [1] = {
                    name = "菜鸟教程",
                    url = "www.runoob.com"
                },
                [2] = {
                    name = "google",
                    url = "www.google.com"
                },
                [3] = {
                    url = "www.weibo.com",
                    name = "微博"
                }
            }
        }
    },
    [3] = {
        id = 3,
        name = "ccc",
        intVal = 0,
        boolVal = false,
        jsonVal = {
            [1] = 1,
            [2] = 1,
            [3] = 1
        }
    }
}
