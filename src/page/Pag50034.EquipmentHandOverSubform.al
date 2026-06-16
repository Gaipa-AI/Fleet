page 50034 "Equipment HandOver Subform"
{
    AutoSplitKey = true;
    DelayedInsert = true;
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = "Form Line";
    SourceTableView = WHERE("Document Type" = FILTER("Equipment Hand Over"));

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Items Present"; Rec."Items Present")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Items Present field.', Comment = '%';
                }
                field(Present; Rec.Present)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Present field.', Comment = '%';
                }
                field(Missing; Rec.Missing)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Missing field.', Comment = '%';
                }
                field(Damaged; Rec.Damaged)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Damaged field.', Comment = '%';
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Remarks field.', Comment = '%';
                }
            }
        }

    }

    actions
    {
        area(Processing)
        {
            action("List Items")
            {

                trigger OnAction()
                var FormHeader: Record "Form Header";
                begin
                    if Confirm('Are you sure you want to list items?', true) then
                    Rec.ListItems();

                end;
            }
        }
    }
}