
pageextension 50019 SalesOrderListExt extends "Sales Order List"
{
    // trigger OnOpenPage()
    // begin
    //     Rec.SetCurrentKey("No.");
    //     Rec.Ascending(false);
    // end;
    views
    {
        addlast
        {
            view(DescendingNo)
            {
                Caption = 'Latest Orders';
                OrderBy = descending("No.");
            }
        }
    }
}