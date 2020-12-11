function loader
    f = waitbar(0,'Please wait...');
    pause(.1)
    
    main();

    waitbar(.33,f,'Opening the application');
    pause(.1)

    waitbar(.67,f,'Opening the application');
    pause(.1)

    waitbar(1,f,'Opening the application');
    pause(.1)

    close(f)
end