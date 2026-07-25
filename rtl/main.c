#include "xil_printf.h"
#include "xil_io.h"
#include "xil_types.h"

//#include "xtime_l.h"

#define KNN_BASE_ADDR     0x43C00000U
#define GPIO_BASE_ADDR    0x41200000U

#define KNN_CTRL_OFFSET   0x00U
#define KNN_X_OFFSET      0x04U
#define KNN_Y_OFFSET      0x08U
#define KNN_K_OFFSET      0x0CU
#define KNN_RES_OFFSET    0x10U

#define GPIO_DATA_OFFSET  0x00U
#define TIMEOUT_LIMIT     1000000U

#define NUM_TESTS         15

typedef struct {
    int x;
    int y;
    int k;
} TestCase;

static TestCase tests[NUM_TESTS] = {
    {8,15,3},
    {12,22,3},
    {18,10,5},
    {25,30,3},
    {35,40,5},
    {45,20,3},
    {50,55,5},
    {60,65,3},
    {70,80,5},
    {85,90,3},
    {95,85,5},
    {33,42,3},
    {66,75,5},
    {20,12,3},
    {40,15,5}
};

static int pl_knn(int x, int y, int k, u32 *status_out)
{
    u32 status;
    u32 timeout = TIMEOUT_LIMIT;

    Xil_Out32(KNN_BASE_ADDR + KNN_X_OFFSET, (u32)x);
    Xil_Out32(KNN_BASE_ADDR + KNN_Y_OFFSET, (u32)y);
    Xil_Out32(KNN_BASE_ADDR + KNN_K_OFFSET, (u32)k);

    Xil_Out32(KNN_BASE_ADDR + KNN_CTRL_OFFSET, 1U);
    Xil_Out32(KNN_BASE_ADDR + KNN_CTRL_OFFSET, 0U);

    do
    {
        status = Xil_In32(KNN_BASE_ADDR + KNN_RES_OFFSET);
        timeout--;
    }
    while(((status & 0x1U) == 0U) && (timeout != 0U));

    *status_out = status;

    if(timeout == 0U)
        return -1;

    return (int)((status >> 1) & 0x1U);
}

int main(void)
{
    int t;
    int x;
    int y;
    int k;
    int result;

    u32 status;
    u32 led_value;

    xil_printf("\r\n===== PS-PL KNN INTEGRATION =====\r\n");
    xil_printf("NUM_TESTS = %d\r\n\r\n", NUM_TESTS);

    Xil_Out32(GPIO_BASE_ADDR + GPIO_DATA_OFFSET, 0x00U);

    for(t = 0; t < NUM_TESTS; t++)
    {
        x = tests[t].x;
        y = tests[t].y;
        k = tests[t].k;

        result = pl_knn(x, y, k, &status);

        if(result < 0)
        {
            xil_printf("Test %d -> x=%d y=%d k=%d\r\n",
                       t+1, x, y, k);
            xil_printf("ERROR: PL accelerator timeout.\r\n");
            xil_printf("Status register = 0x%08x\r\n",
                       status);

            Xil_Out32(GPIO_BASE_ADDR + GPIO_DATA_OFFSET,
                      0x04U);

            xil_printf("LED value written = 0x00000004\r\n\r\n");

            continue;
        }

        led_value = ((u32)(result & 0x1U)) | (1U << 1);

        Xil_Out32(GPIO_BASE_ADDR + GPIO_DATA_OFFSET,
                  led_value);

        xil_printf("Test %d -> x=%d y=%d k=%d\r\n",
                   t+1, x, y, k);
        xil_printf("Done              = %d\r\n",
                   (int)(status & 0x1U));
        xil_printf("KNN Result        = %d\r\n",
                   result);
        xil_printf("Status register   = 0x%08x\r\n",
                   status);
        xil_printf("LED value written = 0x%08x\r\n\r\n",
                   led_value);
    }

    xil_printf("===== BENCHMARK COMPLETE =====\r\n");

    while(1);

    return 0;
}