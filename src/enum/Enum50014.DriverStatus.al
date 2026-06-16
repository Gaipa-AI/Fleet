enum 50014 "Driver Status"
{
    Extensible = true;

    value(0; Active)
    {
        Caption = 'Active';
    }
    value(1; Inactive)
    {
        Caption = 'Inactive';
    }
    value(2; Terminated)
    {
        Caption = 'Terminated';
    }
    value(3; OnLeave)
    {
        Caption = 'On Leave';
    }
}