;; extends
; The base query marks quotes @conceal, which fades them while conceallevel is 0.
(pair key: (string "\"" @property))
(pair value: (string "\"" @string))
(array (string "\"" @string))
