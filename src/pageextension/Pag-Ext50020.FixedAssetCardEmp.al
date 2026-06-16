
pageextension 50020 FixedAssetCardEmp extends "Fixed Asset Card"
{
    layout
    {
        addlast(General)
        {
            field("Employee Name"; EmployeeName)
            {
                ApplicationArea = FixedAssets;
                Caption = 'Employee Name';
                Editable = false;
                ToolTip = 'Displays the name of the employee responsible for this fixed asset.';
            }
        }
    }

    var
        EmployeeName: Text[100];
        EmployeeRec: Record Employee;

    trigger OnAfterGetRecord()
    begin
        Clear(EmployeeName);

        if EmployeeRec.Get(Rec."Responsible Employee") then
            EmployeeName := EmployeeRec."First Name" + ' ' + EmployeeRec."Last Name";
    end;
}
