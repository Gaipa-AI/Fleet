enum 50009 "Job Card Status"
{
    Extensible = true;

    value(0; New)
    {
        Caption = 'New';
    }
    value(1; "In Progress")
    {
        Caption = 'In Progress';
    }
    value(2; "Closed")
    {
        Caption = 'Closed';
    }
    value(3; Cancelled)
    {
        Caption = 'Cancelled';
    }
}