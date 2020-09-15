;������ �� 27.01.16 ; 21.06.16
;�� ������ ������ - 1 �����.

(defun C:Rezka ()
  (vl-load-com)

  (setq LenCRCL 0)			; ������������� ����������
  (setq LenLine 0)
  (setq Prmtr 0)
  (setq cost 0)
  (setq Vrezka 0)

  (defun crcl (EntName)			; ����� ���������� 
    (setq	cr
    (vla-get-circumference (vlax-ename->vla-object EntName))
    )
  )

  (defun plln (EntName)			; ����� ��������� 
    (setq	ln
    (vla-get-length (vlax-ename->vla-object EntName))
    )
  )


  (setq a (ssget "X" '((0 . "CIRCLE"))))	; �������� ������ ���������� (����������, ���� ���������)
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

  (if(/= nil b) (cyclLn)) ; ��������� ������� ����������
  (if(/= nil a) (cyclCRCL))

  (setq rez (getreal "\n ������� ���� �� �������� ���� ���� "))

  (setq Prmtr (+ LenLine LenCRCL))
  (setq cost (* (/ Prmtr 1000) rez))
  (setq cost (+ cost Vrezka))

  (setq cost (rtos cost 2 2))
  ;(print cost)  
  (alert cost)  
)