;;;��������� ��������� �� ��������� ��������� ��������
;;;������ �����, ������� �� ���� point, - ���������
;;;20.07.16

(defun C:Otver ()
(vl-load-com)
(setq acad_object (vlax-get-acad-object))
(setq active_document (vla-get-activedocument acad_object))
(setq model_space (vla-get-modelspace active_document))
(setq radius 0.0)

(setq point (ssget "X" '((0 . "POINT")))) ; ��������� ������ �����

(defun coord (EntName)			; ��������� ��������� �����
  (setq	p1
	 (vla-get-coordinates (vlax-ename->vla-object EntName))
  )
)

(defun lay (EntName) ; ��������� ����� ���� �������(�����)
  (setq l1
	 (vla-Get-Layer (vlax-ename->vla-object EntName))
  )
)

(setq radius (getreal "\n ������� ������ ���������"))

(setq counter 0)
(setq i (- (sslength point) 1))

; �������� �� ������ �����. ���� ���� ����� - point, �� ������ ������ �� ���������� 
(while (<= counter i)   
  (setq obj (ssname point counter))
  (setq buf (coord obj))
  (if (= "point" (lay obj) )
    (vla-addcircle model_space  buf radius)
  )
  (setq counter (+ 1 counter))
)
  
)