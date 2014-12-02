/**    
    @file     famap.h
    @date     2010/12/1
    @author   ����� freefrug@falinux.com  FALinux.Co.,Ltd.
    @brief    mmap ��ƿ��Ƽ�̴�.
              Ver 0.1.0
              
    @modify   
    @todo     
    @bug     
    @remark   
    @warning   tmmap.c  tmmap.h �ʹ� ���� ������� �ʴ´�.
*/
//----------------------------------------------------------------------------

#ifndef _FA_MMAP_H_
#define _FA_MMAP_H_


#ifndef  PAGE_SIZE
#define  PAGE_SIZE  (1024*4)
#endif

/// mmap �� ���� ���� ���� ����ü
typedef struct {
	
	int            dev;         // /dev/mem �����ڵ�
	unsigned long  phys;        // �����ּ�
	unsigned long  size;        // ũ��
	int            base_ofs;    // ���̽� �ּҰ� 4K ������ ���� �ʾ����� ���

	void          *virt;        // �Ҵ���� �޸�������
	
} mmap_alloc_t;

#ifdef __cplusplus 
extern "C" { 
#endif 	

extern void  *fa_mmap_alloc( mmap_alloc_t *ma, unsigned long phys_base, unsigned long size );
extern void   fa_mmap_free ( mmap_alloc_t *ma );

#ifdef __cplusplus 
}
#endif 

#endif // _FA_MMAP_H_
