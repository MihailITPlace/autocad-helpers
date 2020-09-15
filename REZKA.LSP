;Версия на 27.01.16 ; 21.06.16
;За каждую врезку - 1 рубль.

(defun C:Rezka ()
  (vl-load-com)

  (setq LenCRCL 0)			; инициализация переменных
  (setq LenLine 0)
  (setq Prmtr 0)
  (setq cost 0)
  (setq Vrezka 0)

  (defun crcl (EntName)			; длина окружности 
    (setq	cr
    (vla-get-circumference (vlax-ename->vla-object EntName))
    )
  )

  (defun plln (EntName)			; длина полилинии 
    (setq	ln
    (vla-get-length (vlax-ename->vla-object EntName))
    )
  )


  (setq a (ssget "X" '((0 . "CIRCLE"))))	; получаем списки примитивов (окружности, либо полилинии)
  (setq b (ssget "X" '((0 . "LWPOLYLINE"))))


  (defun cyclCrcl	(/ counter)
    (setq counter 0)
    (setq h (- (sslength a) 1))
    (while (<= counter h)
      (crcl (ssname a counter))
      (setq LenCRCL (+ LenCRCL cr))
      (setq Vrezka (+ Vrezka 1))
      (setq counter (+ 1 counter))
    )
  )

  (defun cyclLn (/ counter)
    (setq counter 0)
    (setq h (- (sslength b) 1))
    (while (<= counter h)
      (plln (ssname b counter))
      (setq LenLine (+ Lenline ln))
      (setq Vrezka (+ Vrezka 1))
      (setq counter (+ 1 counter))
    )
  )

  (if(/= nil b) (cyclLn)) ; проверяем наличие примитивов
  (if(/= nil a) (cyclCRCL))

  (setq rez (getreal "\n Введите цену за погонный метр реза "))

  (setq Prmtr (+ LenLine LenCRCL))
  (setq cost (* (/ Prmtr 1000) rez))
  (setq cost (+ cost Vrezka))

  (setq cost (rtos cost 2 2))
  ;(print cost)  
  (alert cost)  
)
