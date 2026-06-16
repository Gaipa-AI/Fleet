page 50069 "Employee Types"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "General value";
    SourceTableView = where(Type = filter("Employee Type"));
    Caption = 'Employee Types';
    layout
    {
        area(Content)
        {
            repeater(List)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                    Caption = 'Code';
                    ToolTip = 'Specifies the code for the equipment type.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Caption = 'Description';
                    ToolTip = 'Specifies a description for the equipment type.';
                }
            }
        }
    }
}