#include <a_samp>

public OnGameModeInit()
{
    /*
	 онструкци¤ цикла do while (цикл с постусловием):
	do
	{
	    // тело цикла do while (выполнитс¤ один раз и, затем, будет выполн¤тьс¤
		// до тех пор, пока результат услови¤_продолжени¤_цикла не будет false)
	}
	while( условие_продолжени¤_цикла );
	*/
	
 	const start_count = 1;
	const end_count = 10;
	
//-------------------------------------------------
	printf("—читаем от %d до %d использу¤ цикл do while:", start_count, end_count);
	new count = start_count;
	do
	{
		printf("%d", count);
		// count++; - инкремент, а count--; - декремент
		count++; // count = count + 1; или count += 1;
	}
	while(count <= end_count);
//-------------------------------------------------

	printf("—читаем от %d до %d использу¤ цикл for:", start_count, end_count);
	for(new i = start_count; i <= end_count; i++)
	{
	    printf("%d", i);
	}
 	// i = 32; // ошибка, так как переменна¤ i доступна только в теле цикла for
//-------------------------------------------------

	printf("—читаем от %d до %d использу¤ цикл while:", start_count, end_count);
	count = start_count;
	while(count <= end_count)
	{
		printf("%d", count);
		count++;
	}
 	return 1;
}

main()
{

}
