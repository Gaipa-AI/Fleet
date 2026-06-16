page 50067 Departments
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "General value";
    SourceTableView = where(Type = filter(Department));
    Caption = 'Departments';
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